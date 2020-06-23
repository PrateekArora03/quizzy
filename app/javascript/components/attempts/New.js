import React, { useState } from "react";
import API from "../../utils/API";
import Alert from "../layouts/Alert";

const New = ({ quiz }) => {
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [email, setEmail] = useState("");
  const [messages, setMessages] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();
    setMessages({});
    try {
      const response = await API(`/public/${quiz.slug}/attempts/`, "post", {
        user: {
          first_name: firstName,
          last_name: lastName,
          email,
        },
      });
      window.location.href = `/public/${quiz.slug}/attempts/${response.data.attempt_id}/edit`;
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };
  return (
    <div className="container">
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <div className="row justify-content-md-center flex-column align-items-center">
        <div className="bg-light border jumbotron mt-3 mb-3 col-sm-8">
          <h1 className="display-5">Welcome to Quizzy!</h1>
          <p className="text-black-50">
            Please fill the information before attempting the{" "}
            <strong>{quiz.name}</strong> quiz
          </p>
        </div>
        <form onSubmit={handleSubmit} className="col-sm-8 p-3">
          <div className="form-row">
            <div className="form-group col-md-6">
              <label htmlFor="forFirstName">First Name</label>
              <input
                type="text"
                className="form-control"
                id="forFirstName"
                placeholder="First Name"
                value={firstName}
                onChange={({ target: { value } }) => setFirstName(value)}
              />
            </div>
            <div className="form-group col-md-6">
              <label htmlFor="forLastName">Last Name</label>
              <input
                type="text"
                className="form-control"
                id="forLastName"
                placeholder="Last Name"
                value={lastName}
                onChange={({ target: { value } }) => setLastName(value)}
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
              value={email}
              onChange={({ target: { value } }) => setEmail(value)}
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
