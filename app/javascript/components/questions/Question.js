import React from "react";
import PropTypes from "prop-types";
import API from "../../utils/API";

function Question({ question, quiz_id, index }) {
  const handleDelete = async (id) => {
    try {
      const questionDelete = confirm(
        "Are you sure you want to delete this Question"
      );
      if (questionDelete) {
        await API(`/quizzes/${quiz_id}/questions/${id}`, "delete");
        window.location.href = `/quizzes/${quiz_id}`;
      }
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };
  return (
    <div className="container mt-4 mb-5">
      <div className="row mb-2">
        <div className="col-2">
          <label className="text-muted">Question {index}</label>
        </div>
        <div className="col-4">{question.description}</div>
        <div className="col-2 d-flex justify-content-between">
          <a
            href={`/quizzes/${quiz_id}/questions/${question.id}/edit`}
            className="btn btn-secondary"
          >
            Edit
          </a>
          <button
            onClick={() => handleDelete(question.id)}
            type="button"
            className="btn btn-danger"
          >
            Delete
          </button>
        </div>
      </div>
      {question.options.map((option, index) => {
        return (
          <div key={index} className="row">
            <div className="col-2">
              <label className="text-muted">Option {index + 1}</label>
            </div>
            <div className="col-4 d-flex justify-content-between">
              {option}{" "}
              {question.correct_answer === index + 1 && (
                <span style={{ color: "#019f0f" }}>✅ Correct answer</span>
              )}
            </div>
          </div>
        );
      })}
    </div>
  );
}

Question.propTypes = {
  question: PropTypes.object.isRequired,
};

export default Question;
