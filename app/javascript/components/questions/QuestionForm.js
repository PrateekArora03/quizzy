import React, { useState, Fragment } from "react";
import PropTypes from "prop-types";
import Alert from "../layouts/Alert";
import API from "../../utils/API";

const QuestionForm = ({ quiz, questionData }) => {
  const [question, setQuestion] = useState(
    !questionData
      ? {
          description: "",
          options: ["", ""],
          correct_answer: null,
        }
      : { ...questionData }
  );
  const [messages, setMessages] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      let response;

      if (question.description === "") {
        response = {
          errors: ["Question can't be blank."],
          type: "danger",
        };
        setMessages(response);
      }

      await question.options.forEach((option) => {
        if (option === "") {
          response = {
            errors: ["Options can't be blank."],
            type: "danger",
          };
          setMessages(response);
        }
      });

      if (question.correct_answer === null) {
        response = {
          errors: ["Please select correct answer."],
          type: "danger",
        };
        setMessages(response);
      }

      if (response === undefined) {
        await API(
          `/quizzes/${quiz.id}/${
            questionData ? `questions/${question.id}` : `questions`
          }`,
          questionData ? "put" : "post",
          {
            question,
          }
        );
        window.location.href = `/quizzes/${quiz.id}`;
      }
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };

  const handleDeleteOptions = (index) => {
    const updatedOptions = [...question.options];
    updatedOptions.splice(index, 1);
    setQuestion({ ...question, options: updatedOptions, correct_answer: null });
  };

  const handleOptions = (value, index) => {
    const updatedOptions = [...question.options];
    updatedOptions[index] = value;
    setQuestion({ ...question, options: updatedOptions });
  };

  const handleAddOptions = () => {
    const updatedOptions = [...question.options];
    updatedOptions[updatedOptions.length] = "";
    setQuestion({ ...question, options: updatedOptions });
  };

  return (
    <Fragment>
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <h3 className="text-secondary font-weight-bold pb-3">{quiz.name}</h3>
      <form onSubmit={handleSubmit}>
        <div className="d-flex align-items-baseline col-md-6 mb-3 justify-content-between">
          <label
            htmlFor="quiz-name"
            className="text-secondary mr-2 font-weight-bold"
          >
            Question
          </label>
          <input
            type="text"
            value={question.description}
            onChange={({ target: { value } }) =>
              setQuestion({ ...question, description: value })
            }
            className="form-control"
          />
        </div>
        {question.options.map((option, index) => {
          return (
            <div
              key={index}
              className="d-flex align-items-baseline col-md-6 mb-3 justify-content-between"
            >
              <label
                htmlFor="quiz-name"
                className="text-secondary text-nowrap mr-2"
              >
                Option {index + 1}
              </label>
              <input
                type="text"
                value={question.options[index]}
                onChange={({ target: { value } }) =>
                  handleOptions(value, index)
                }
                className="form-control"
              />
              {index > 1 && (
                <button
                  onClick={() => handleDeleteOptions(index)}
                  type="button"
                  className="ml-1 btn btn-danger"
                >
                  X
                </button>
              )}
            </div>
          );
        })}
        {question.options.length < 4 && (
          <div className="col-md-6 mb-3">
            <a
              className="text-primary pl-3 ml-5"
              style={{ cursor: "pointer" }}
              onClick={handleAddOptions}
            >
              + Add option
            </a>
          </div>
        )}
        <div className="d-flex align-items-baseline col-md-6 mb-3 justify-content-between">
          <label
            htmlFor="quiz-name"
            className="text-secondary text-nowrap mr-2"
          >
            Correct answer
          </label>
          <select
            name="correct-answer"
            onChange={({ target: { value } }) =>
              setQuestion({ ...question, correct_answer: value })
            }
            value={String(question.correct_answer)}
            className="form-control"
            id="correct-answer"
          >
            <option value="null" disabled>
              Select answer
            </option>
            {question.options.map((option, index) => (
              <option value={index + 1} key={index}>
                Option {index + 1}
              </option>
            ))}
          </select>
        </div>
        <div className="col-md-6 mb-3">
          <button type="submit" className="btn btn-primary mb-2">
            {questionData ? "Update Question" : "Add Question"}
          </button>
        </div>
      </form>
    </Fragment>
  );
};

QuestionForm.prototype = {
  quiz: PropTypes.object.isRequired,
  question: PropTypes.object,
};

export default QuestionForm;
