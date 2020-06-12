import React, { Fragment } from "react";
import PropTypes from "prop-types";

const Quiz = ({ quiz }) => {
  return (
    <Fragment>
      <div className="d-flex justify-content-end">
        <a
          href={`/quizzes/${quiz.id}/questions/new`}
          className="btn btn-primary"
        >
          Add questions
        </a>
      </div>
      <div className="d-flex mt-3 justify-content-center">
        <span className="text-muted">There are no questions in this quiz.</span>
      </div>
    </Fragment>
  );
};

Quiz.prototype = {
  quiz: PropTypes.object.isRequired,
};

export default Quiz;
