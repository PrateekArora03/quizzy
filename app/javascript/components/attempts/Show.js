import React from "react";

const Show = ({
  correct_answers_count,
  incorrect_answers_count,
  questions,
  attempts,
}) => {
  return (
    <div className="container">
      {console.log(questions)}
      {console.log(attempts)}
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
            <div className="mt-2 mb-4 d-flex justify-content-between">
              <h5 class="col-4">
                <span class="badge badge-warning">Question {index + 1}</span>
              </h5>
              <div class="col-8 p-0 pb-4">
                <p>{attempt.question.description}</p>
                <div>
                  {attempt.question.options.map((option, index) => (
                    <div
                      class={
                        attempt.question.correct_answer ===
                          attempt.submitted_option &&
                        attempt.submitted_option === index + 1
                          ? "input-group mt-1 border border-success"
                          : "input-group mt-1"
                      }
                    >
                      <div class="input-group-prepend">
                        <div class="input-group-text">
                          <input
                            type="radio"
                            class="option-select"
                            name={`${attempt.question.id}-option`}
                            disabled="true"
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
                          class="btn btn-danger close"
                          aria-label="Close"
                          disabled=""
                        >
                          <span
                            class="rounded-0 text-white input-group-text"
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
