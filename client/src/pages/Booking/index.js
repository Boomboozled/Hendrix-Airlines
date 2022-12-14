import React, {useContext, useState} from 'react'
import {Formik} from 'formik'
import {FormikForm, initialValues, BookButton, BookingContainer} from './BookingElements';
import {FlightListContainer,
    FModal,
    PassengerSelect,
    DepartureCalendar
} from "./BookingFunctions";
import axios from 'axios';
import Navbar from "../../components/Navbar";
import {TextBox} from "../../components/FormFields";
import {bookingSchema} from "./bookingSchema";
import { PassengerContext } from "../../components/UserContext";


const Booking = () => {

    const [flightList, setFlightList] = useState([]);
    const [isModalOpen, setIsModalOpen] = useState(false)
    const [planeLayout, setPlaneLayout] = useState([])
    const {setPassengerList} = useContext(PassengerContext);

    const onSubmit = async (values, { setSubmitting }) => {
        setSubmitting(true);
        console.log('onSubmitPressed')

        //GetMonth has +1, because Calendar forms denote January as 0, February as 1, and so on. In order to make the queries work, it needs to be the month how we usually denote it.
        const res = await axios.get(`http://localhost:5005/book/${values.sourceAirport.toUpperCase()}/${values.destinationAirport.toUpperCase()}/${values.departDate.getFullYear()}-${values.departDate.getMonth() + 1}-${values.departDate.getDate()}/${values.passengerSelect}`);

        console.log(res)
        setFlightList(res.data)
        setSubmitting(false);
        //set current flight should be empty list i believe or null?
        //setCurrentFlight([])



          setPassengerList([...Array(parseInt(values.passengerSelect))].map(() => {
            return { row: null, column: null };
          }))

    }


    return(

        <>

            {isModalOpen && <FModal setIsModalOpen={setIsModalOpen} planeLayout={planeLayout}> </FModal>}

            <Navbar />

            <BookingContainer>
                <Formik
                    validateOnChange={true}
                    initialValues={initialValues}
                    validationSchema={bookingSchema}
                    onSubmit={onSubmit}>

                    {({ isSubmitting }) => (
                    <FormikForm>
                        <TextBox name="sourceAirport" label="From" />
                        <TextBox name="destinationAirport" label="To" />
                        <DepartureCalendar name="departDate"></DepartureCalendar>
                        <PassengerSelect name="passengerSelect"> </PassengerSelect>
                        <BookButton disabled={isSubmitting} type="submit">Search</BookButton>
                    </FormikForm>
                    )}
                </Formik>
                <FlightListContainer
                flightList={flightList}
                setIsModalOpen={setIsModalOpen}
                planeLayout={planeLayout}
                setPlaneLayout={setPlaneLayout}
                ></FlightListContainer>

            </BookingContainer>
        </>
    )

}

export default Booking;