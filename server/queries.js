const Pool = require('pg').Pool
const pool = new Pool({
    host: "localhost",
    user: "postgres",
    password: "hendrix",
    port: 5432,
    database: "postgres"
})

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
  const email = request.params.email;

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


  pool.query("INSERT INTO account VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, 'user') RETURNING *",
   [email, password, fname, mname, lname, suffix, dob, gender, address, address2, phone, city, zip, state], (error, results) => {
    if (error) {
        response.sendStatus(503);
        console.log(error);
    } else {
        response.status(201).send(`User added with email: ${results.rows[0].id}`)
    }
  })
}

const updateAccount = (request, response) => {
  const email = request.params.email;
  const {password} = request.body;

  pool.query('UPDATE account SET password = $1 WHERE email = $2', [password, email], (error, results) => {
      if (error) {
          response.sendStatus(503);
      } else {
          response.status(200).send(`User modified with email: ${email}`);
      }
    })
}

const deleteAccount = (request, response) => {
  const email = request.params.email;

  pool.query('DELETE FROM account WHERE email = $1', [email], (error, results) => {
    if (error) {
        response.sendStatus(503);
    } else {
        response.status(200).send(`User deleted with email: ${email}`);
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

const getFlightsBySearch = (request, response) => {
  //parameters for the route, request.body is the body of the request, req.query is query parameters
  const {source,destination, departure, passengers}= request.params;

  pool.query('SELECT * FROM Flight natural join Plane NATURAL JOIN (SELECT regno from seat where istaken = false group by regno having count(istaken) - $4 >= 0) as capacity where source_gate_code = $1 and destination_gate_code = $2 and date(departure) = $3', [source, destination, departure, passengers] ,(error, results) =>{
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
  const email = request.params.email;

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
  const confirmation_no = request.params.confirmation_no;

  pool.query('SELECT * FROM trip WHERE confirmation_no = $1', [confirmation_no] ,(error, results) =>{
    if(error)
    {
      response.sendStatus(503);
    }
    else{
      response.status(200).json(results.rows)
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
    getTripByConfirmationNo
}