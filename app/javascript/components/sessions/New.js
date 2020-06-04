import React, { useState, Fragment } from "react";

export default () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  return (
    <Fragment>
      <div className="form-row">
        <div className="form-group col-md-4">
          <label htmlFor="email">Email address</label>
          <input
            type="email"
            className="form-control"
            id="email"
            name="email"
            onChange={({ target: { value } }) => setEmail(value)}
          />
        </div>
      </div>
      <div className="form-row">
        <div className="form-group col-md-4">
          <label htmlFor="password">Password</label>
          <input
            type="password"
            className="form-control"
            id="password"
            name="password"
            onChange={({ target: { value } }) => setPassword(value)}
          />
        </div>
      </div>
      <button type="submit" className="btn btn-primary">
        Sign In
      </button>
    </Fragment>
  );
};
