import React from "react";

const Show = ({ correct_answers_count, incorrect_answers_count }) => (
  <div className="row p-4 justify-content-center">
    <div class="p-4 jumbotron col-8 border border-success bg-light">
      <h3 class="display-5">Thank you for taking the quiz!</h3>
      <hr class="my-4" />
      <p class="lead">
        You have{" "}
        <strong>
          <span class="text-success">{correct_answers_count}</span>
        </strong>{" "}
        correct answers and{" "}
        <strong>
          <span class="text-danger">{incorrect_answers_count}</span>
        </strong>{" "}
        incorrect answers
      </p>
    </div>
    <div class="row justify-content-center">
      <div class="pt-4 col-12">
        <div class="mt-2 mb-4 d-flex justify-content-between">
          <h5 class="col-4">
            <span class="badge badge-warning">Question 1</span>
          </h5>
          <div class="col-8 p-0 pb-4">
            <p>Solor system</p>
            <div>
              <div class=" input-group mt-1">
                <div class="input-group-prepend">
                  <div class="input-group-text">
                    <input
                      type="radio"
                      class="option-select"
                      name="0-option"
                      disabled=""
                      value="sun"
                    />
                  </div>
                </div>
                <input
                  type="text"
                  class="form-control option-value"
                  name="option[value]"
                  disabled=""
                  value="sun"
                />
              </div>
              <div class="border rounded border-success input-group mt-1">
                <div class="input-group-prepend">
                  <div class="input-group-text">
                    <input
                      type="radio"
                      class="option-select"
                      name="0-option"
                      disabled=""
                      value="sunaa"
                      checked=""
                    />
                  </div>
                </div>
                <input
                  type="text"
                  class="form-control option-value"
                  name="option[value]"
                  disabled=""
                  value="sunaa"
                />
                <div
                  class="input-group-append"
                  data-toggle="tooltip"
                  data-placement="right"
                  title="Correct Answer"
                >
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
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
);

export default Show;
