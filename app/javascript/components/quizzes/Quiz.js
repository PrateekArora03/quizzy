import React, { Fragment } from "react";
import PropTypes from "prop-types";
import Question from "../questions/Question";

const Quiz = ({ quiz, questions }) => {
  return (
    <Fragment>
      <div className="d-flex justify-content-end mb-3">
        <a
          href={`/quizzes/${quiz.id}/questions/new`}
          className="btn btn-primary mr-2"
        >
          Add questions
        </a>
        {questions.length > 0 && (
          <a href="#" className="btn btn-primary">
            Publish
          </a>
        )}
      </div>
      {questions.length > 0 ? (
        questions.map((question, index) => (
          <Question
            key={question.id}
            index={index + 1}
            quiz_id={quiz.id}
            question={question}
          />
        ))
      ) : (
        <div className="d-flex mt-3 justify-content-center">
          <span className="text-muted">
            There are no questions in this quiz.
          </span>
        </div>
      )}
    </Fragment>
  );
};

Quiz.prototype = {
  quiz: PropTypes.object.isRequired,
  questions: PropTypes.array.isRequired,
};

export default Quiz;
