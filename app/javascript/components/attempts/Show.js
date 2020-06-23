import React from "react";

const Show = ({ correct_answers_count, incorrect_answers_count, attempts }) => {
  return (
    <div className="container">
      <div className="row d-flex p-4 justify-content-center">
        <div className="p-4 jumbotron col-8 border border-success bg-light">
          <h3 className="display-5">Thank you for taking the quiz!</h3>
          <hr className="my-4" />
          <p className="lead">
            You have{" "}
            <strong>
              <span className="text-success">{correct_answers_count}</span>
            </strong>{" "}
            correct answers and{" "}
            <strong>
              <span className="text-danger">{incorrect_answers_count}</span>
            </strong>{" "}
            incorrect answers
          </p>
        </div>
      </div>
      <div className="row justify-content-center">
        <div className="pt-4 col-8">
          {attempts.map((attempt, index) => (
            <div
              key={attempt.id}
              className="mt-2 mb-4 d-flex justify-content-between"
            >
              <h5 className="col-4">
                <span className="badge badge-warning">
                  Question {index + 1}
                </span>
              </h5>
              <div className="col-8 p-0 pb-4">
                <p>{attempt.question.description}</p>
                <div>
                  {attempt.question.options.map((option, index) => (
                    <div
                      key={option}
                      className={
                        attempt.question.correct_answer ===
                          attempt.submitted_option &&
                        attempt.submitted_option === index + 1
                          ? "input-group mt-1 border border-success"
                          : "input-group mt-1"
                      }
                    >
                      <div className="input-group-prepend">
                        <div className="input-group-text">
                          <input
                            type="radio"
                            className="option-select"
                            name={`${attempt.question.id}-option`}
                            disabled={true}
                            checked={
                              index + 1 === attempt.submitted_option
                                ? true
                                : false
                            }
                            value={index + 1}
                          />
                        </div>
                      </div>
                      <div className="form-control option-value">{option}</div>
                      {index + 1 === attempt.question.correct_answer && (
                        <button
                          type="button"
                          className="btn btn-danger close"
                          aria-label="Close"
                          disabled=""
                        >
                          <span
                            className="rounded-0 text-white input-group-text"
                            aria-hidden="true"
                          >
                            ✔️
                          </span>
                        </button>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Show;
