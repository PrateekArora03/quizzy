import React from "react";
import PropTypes from "prop-types";
import API from "../../utils/API";

const Header = ({ user, logged_in }) => {
  const handleLogOut = async () => {
    const res = await API(`/sessions/${user.id}`, "delete");
    if (res.status === 200) {
      window.location.href = "/";
    }
  };
  return (
    <header className="navbar navbar-fixed-top navbar-dark bg-primary mb-2">
      <nav className="container">
        <a href="/" className="navbar-brand">
          Quizzy
        </a>
        <div>
          {logged_in ? (
            <div className="d-flex align-items-center">
              <span className="navbar-brand mr-2">
                {user.first_name + " " + user.last_name}
              </span>
              <button
                onClick={handleLogOut}
                type="button"
                className="btn btn-danger btn-sm"
              >
                Logout
              </button>
            </div>
          ) : (
            <a href="/login" className="navbar-brand">
              Login
            </a>
          )}
        </div>
      </nav>
    </header>
  );
};

Header.propTypes = {
  user: PropTypes.object,
  logged_in: PropTypes.bool.isRequired,
};

export default Header;
