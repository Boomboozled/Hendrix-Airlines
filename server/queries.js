const Pool = require('pg').Pool
const pool = new Pool({
    host: "localhost",
    user: "postgres",
    password: "hendrix",
    port: 5432,
    database: "postgres"
})

var temp_client = null;

const getAccounts = (request, response) => {
    pool.query('SELECT * FROM account', (error, results)=>{
    if(error){
        response.sendStatus(503);
    } else {
        response.status(200).json(results.rows);
    }
})
}

const getAccountByEmail = (request, response) => {
  const {email} = request.params;

  pool.query('SELECT * FROM account WHERE email = $1', [email], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else {
        response.status(200).json(results.rows);
    }
  })
}

const createAccount = (request, response) => {
  const {address,
      address2,
      city,
      dob,
      email,
      fname,
      gender,
      lname,
      mname,
      password,
      phone,
      state,
      suffix,
      zip
  } = request.body


  pool.query("INSERT INTO account VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) RETURNING *",
   [email, password, fname, mname, lname, suffix, dob, gender, address, address2, phone, city, zip, state], (error, results) => {
    if (error) {
        response.sendStatus(503);
        console.log(error);
    } else {
        response.sendStatus(201)
    }
  })
}

const updateAccount = (request, response) => {
  const {email} = request.params;
  const {password} = request.body;

  pool.query('UPDATE account SET password = $1 WHERE email = $2', [password, email], (error, results) => {
      if (error) {
          response.sendStatus(503);
      } else {
          response.sendStatus(200)
      }
    })
}

const deleteAccount = (request, response) => {
  const {email} = request.params;

  pool.query('DELETE FROM account WHERE email = $1', [email], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else {
        response.sendStatus(200)
    }
  })
}



/*   This was the old query we relied on for a while, leaving here for reference
     
const getFlightsBySearch = (request, response) => {
//   //parameters for the route, request.body is the body of the request, req.query is query parameters
//   const {source,destination, departure, passengers}= request.params;
//   pool.query("SELECT * FROM Flight natural join Plane where source_gate_code = $1 and destination_gate_code = $2 and date(departure) = $3 and maincabinseats + firstclassseats - passengers >= $4", [source, destination, departure, passengers] ,(error, results) =>{
//     if(error)
//     {
//       response.sendStatus(503);
//     }
//     else{
//       response.status(200).json(results.rows)
//     }
//   })
} */

//New Updated query

// const getFlightsBySearch = (request, response) => {
//   //parameters for the route, request.body is the body of the request, req.query is query parameters
//   const {source,destination, departure, passengers} = request.params;

//   pool.query('SELECT * FROM Flight natural join Plane NATURAL JOIN (SELECT regno from seat where istaken = false group by regno having count(istaken) - $4 >= 0) as capacity where source_gate_code = $1 and destination_gate_code = $2 and date(departure) = $3', [source, destination, departure, passengers] ,(error, results) =>{
//     if(error)
//     {
//       response.sendStatus(503);
//     }
//     else{
//       response.status(200).json(results.rows)
//     }
//   })
// }




const getFlightsBySearch = (request, response) => {
  //parameters for the route, request.body is the body of the request, req.query is query parameters
  const {source,destination, departure, passengers} = request.params;

  pool.query('SELECT * FROM Flight natural join Plane NATURAL JOIN (SELECT regno from seat where passenger is null group by regno having count(*) - $4 >= 0) as capacity where source_gate_code = $1 and destination_gate_code = $2 and date(departure) = $3', [source, destination, departure, passengers] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
    }
  })
}



const getPlaneLayout = (request, response) => {
  //parameters for the route, request.body is the body of the request, req.query is query parameters
  const {regno}= request.params;

  pool.query("SELECT * FROM Seat where regno = $1 order by columnletter, row", [regno] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
    }
  })
}

const getTripsByEmail = (request, response) => {
  const {email} = request.params;

  pool.query('SELECT * FROM trip WHERE email = $1', [email] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
    }
  })
}

const getTripByConfirmationNo = (request, response) => {
  const {confirmation_no} = request.params;

  pool.query('SELECT * FROM flight JOIN trip ON flight_no=flightno WHERE confirmation_no = $1', [confirmation_no] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
    }
  })
}

const getPassengersOnTrip = (request, response) => {
  const {confirmation_no} = request.params;

  pool.query('SELECT passenger.* FROM trip JOIN passenger ON passenger1=ticketno OR passenger2=ticketno OR passenger3=ticketno OR passenger4=ticketno OR passenger5=ticketno WHERE confirmation_no = $1;', [confirmation_no] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
    }
  })
}

const createPassenger = (request, response) => {
  const {fname,
      mname,
      lname,
      dob,
      gender,
      state,
      bags,
      ticketno
  } = request.body

  temp_client.query("INSERT INTO passenger VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *",
   [ticketno, fname, mname, lname, dob, gender, state, bags], async (error, results) => {
    if (error) {
        response.sendStatus(503);
        console.log("create passenger", error);
        await temp_client.query("ROLLBACK")
        temp_client.release()
    } else {
        response.sendStatus(201)
    }
  })
}

const createCreditCard = async (request, response) => {
  const {name,
      card_number,
      exp_date,
      cvv,
      zip,
      account
  } = request.body
  const client = await pool.connect() // creating a constant client for transaction

  await client.query("BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED")

  await client.query("SAVEPOINT before_credit_card_insert")

  client.query("INSERT INTO credit_card VALUES ($1, $2, $3, $4, $5, $6) RETURNING *",
   [card_number, exp_date, cvv, zip, name, account], async (error, results) => {
      if(error) {
          await client.query("ROLLBACK TO SAVEPOINT before_credit_card_insert")
      }
    response.sendStatus(201)
    temp_client = client // client will release later
  })
}

const createTrip = (request, response) => {
  const {email,
      flight_no,
      ticketnoList,
      confirmation_no
  } = request.body

  temp_client.query("INSERT INTO trip VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *", [email, flight_no, ticketnoList[0],
      ticketnoList[1], ticketnoList[2], ticketnoList[3], ticketnoList[4], confirmation_no], async (error, results) => {
    if (error) {
        response.sendStatus(503)
        console.log("create trip", error)
        await temp_client.query("ROLLBACK")
    } else {
        response.sendStatus(201)
        await temp_client.query("COMMIT")
    }
  })

  temp_client.release()
}

const updateSeat = (request, response) => {
  const {regno, row, column} = request.params;
  const {passenger} = request.body;

  temp_client.query('UPDATE seat SET passenger = $1 WHERE regno = $2 AND row = $3 AND columnletter = $4', [passenger, regno, row, column], async (error, results) => {
      if (error) {
        response.sendStatus(503);
        console.log(error);
        await temp_client.query("ROLLBACK")
        temp_client.release()
      } else {
          response.sendStatus(200)
      }
    })
}

const deleteTrip = (request, response) => {
  const {confirmation_no} = request.params;

  pool.query('SELECT canceltrip($1)', [confirmation_no], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else if (!results.rows[0].canceltrip) {
        response.sendStatus(406);
    } else {
        response.sendStatus(200)
    }
  })
}

const getCreditCardsByEmail = (request, response) => {
  const { email } = request.params;

  pool.query('SELECT * FROM credit_card WHERE account = $1', [email], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else {
        response.status(200).json(results.rows);
    }
  })
}

const deleteCreditCard = (request, response) => {
  const { card_number } = request.params;

  pool.query('DELETE FROM credit_card WHERE card_number = $1', [card_number], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else {
        response.sendStatus(200)
    }
  })
}

module.exports = {
    getAccounts,
    getAccountByEmail,
    createAccount,
    updateAccount,
    deleteAccount,
    getFlightsBySearch,
    getPlaneLayout,
    getTripsByEmail,
    getTripByConfirmationNo,
    createPassenger,
    createCreditCard,
    createTrip,
    updateSeat,
    deleteTrip,
    getCreditCardsByEmail,
    deleteCreditCard,
    getPassengersOnTrip
}