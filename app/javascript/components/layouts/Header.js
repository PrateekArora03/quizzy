import React from "react";
import PropTypes from "prop-types";
import API from "../../utils/API";
import routes from "../../utils/routes";

const Header = ({ user, logged_in }) => {
  const handleLogOut = async () => {
    const response = await API(`/sessions`, "delete");
    if (response.status === 200) {
      window.location.href = "/";
    }
  };
  return (
    <header className="navbar navbar-fixed-top navbar-dark bg-primary mb-3">
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
              <a href="/reports" className="btn btn-success btn-sm mr-2">
                Reports
              </a>
              <button
                onClick={handleLogOut}
                type="button"
                className="btn btn-danger btn-sm"
              >
                Logout
              </button>
            </div>
          ) : (
            <div>
              {window.location.pathname !== "/sessions/new" && (
                <a href={routes.new_session_path()} className="navbar-brand">
                  Login
                </a>
              )}
            </div>
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
