import React, { useState } from "react";
import API from "../../utils/API";
import Alert from "../layouts/Alert";
import routes from "../../utils/routes";

const Edit = ({ quiz_name, questions, attempt_id, quiz_slug }) => {
  const [attempts, setAttempts] = useState(
    Array.apply(null, Array(questions.length))
  );
  const [messages, setMessages] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      if (
        attempts.includes(undefined) ||
        attempts.length !== questions.length
      ) {
        const response = {
          errors: ["Please attempt all questions."],
          type: "danger",
        };
        setMessages(response);
      } else {
        await API(routes.attempt_path(quiz_slug, attempt_id), "put", {
          attempts: { options: attempts },
        });
        window.location.href = routes.attempt_path(quiz_slug, attempt_id);
      }
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };

  const handleSelect = (event) => {
    setMessages({});
    const updatedAttempts = [...attempts];
    updatedAttempts[event.target.name] = Number(event.target.value);
    setAttempts(updatedAttempts);
  };

  return (
    <div>
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <h2>{quiz_name} Quiz</h2>

      <form onSubmit={handleSubmit} className="col-sm-8 p-3">
        {questions.map((question, questionIndex) => (
          <div key={question.id} className="pt-4">
            <div className="mt-2 mb-4 d-flex justify-content-between">
              <h5 className="col-4">
                <span className="badge badge-warning">
                  Question {questionIndex + 1}
                </span>
              </h5>
              <div className="col-8 p-0 pb-4">
                <p>{question.description}</p>
                <div>
                  {question.options.map((option, index) => (
                    <div key={index} className=" input-group mt-1">
                      <div className="input-group-prepend">
                        <div className="input-group-text">
                          <input
                            onClick={handleSelect}
                            type="radio"
                            className="option-select"
                            name={questionIndex}
                            value={index + 1}
                          />
                        </div>
                      </div>
                      <div className="form-control option-value">{option}</div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        ))}
        <button type="submit" className="float-right btn btn-success">
          Submit
        </button>
      </form>
    </div>
  );
};

export default Edit;
