import React, { Fragment, useState } from "react";
import PropTypes from "prop-types";
import Question from "../questions/Question";
import API from "../../utils/API";
import Alert from "../layouts/Alert";
import routes from "../../utils/routes";

const Quiz = ({ quiz, questions }) => {
  const [slug, setSlug] = useState(quiz.slug);
  const [messages, setMessages] = useState([]);

  const handlePublish = async () => {
    try {
      const response = await API(routes.quiz_path(quiz.id), "put", {
        publish: true,
      });
      setSlug(response.data.slug);
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };

  return (
    <Fragment>
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <div className="row justify-content-between align-items-center w-100 m-0 border-bottom pb-1">
        <div>
          <h3 className="m-0">{quiz.name}</h3>
          <small className="text-black-50">{questions.length} questions</small>
        </div>
        <div>
          <div className="d-flex justify-content-end mb-3">
            <a
              href={routes.new_question_path(quiz.id)}
              className="btn btn-primary mr-2"
            >
              Add questions
            </a>
            {questions.length > 0 &&
              (slug ? (
                <button type="button" className="btn btn-success">
                  ✅ Published
                </button>
              ) : (
                <button
                  onClick={handlePublish}
                  type="button"
                  className="btn btn-success"
                >
                  Publish
                </button>
              ))}
          </div>
        </div>
      </div>

      {slug && (
        <div className="alert alert-info mb-3" role="alert">
          This quiz is published here —{" "}
          <a href={"/public/" + slug + "/attempts/new"} target="_blank">
            {window.location.origin + "/public/" + slug + "/attempts/new"}
          </a>
        </div>
      )}
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
