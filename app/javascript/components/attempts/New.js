import React from "react";
import PropTypes from "prop-types";

const New = ({ quiz }) => {
  return (
    <div className="container">
      <div className="row justify-content-md-center flex-column align-items-center">
        <div className="bg-light border jumbotron mt-3 mb-3 col-sm-8">
          <h1 className="display-5">Welcome to Quizzy!</h1>
          <p className="text-black-50">
            Please fill the information before attempting the{" "}
            <strong>{quiz.name}</strong> quiz
          </p>
        </div>
        <form className="col-sm-8 p-3">
          <div className="form-row">
            <div className="form-group col-md-6">
              <label htmlFor="forFirstName">First Name</label>
              <input
                type="text"
                className="form-control"
                id="forFirstName"
                placeholder="First Name"
              />
            </div>
            <div className="form-group col-md-6">
              <label htmlFor="forLastName">Last Name</label>
              <input
                type="text"
                className="form-control"
                id="forLastName"
                placeholder="Last Name"
              />
            </div>
          </div>
          <div className="form-group">
            <label htmlFor="forEmail">Email</label>
            <input
              type="email"
              className="form-control"
              id="forEmail"
              placeholder="Email"
            />
          </div>
          <button type="submit" className="btn btn-primary">
            Next
          </button>
        </form>
      </div>
    </div>
  );
};

export default New;
