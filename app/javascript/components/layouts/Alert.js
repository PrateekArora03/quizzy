import React from "react";
import PropTypes from "prop-types";

const Alert = ({ messages }) => {
  return (
    <div>
      {messages.errors.map((message) => (
        <div key={message} className={`alert alert-${messages.type}`}>
          {message}
        </div>
      ))}
    </div>
  );
};

Alert.propTypes = {
  messages: PropTypes.object.isRequired,
};

export default Alert;
