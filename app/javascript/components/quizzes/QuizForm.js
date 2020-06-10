import React, { useState, Fragment } from "react";
import Alert from "../layouts/Alert";
import API from "../../utils/API";

const New = (props) => {
  const [quiz, setQuiz] = useState(props.quiz ? props.quiz.name : "");
  const [messages, setMessages] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      await API(
        props.quiz ? `/quizzes/${props.quiz.id}` : "/quizzes",
        props.quiz ? "put" : "post",
        { quiz: { name: quiz } }
      );
      window.location.href = "/";
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };

  return (
    <Fragment>
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <h3 className="pb-3">{props.quiz ? "Update" : "Add New"} Quiz</h3>
      <form onSubmit={handleSubmit}>
        <div className="col-md-6 mb-3">
          <label htmlFor="quiz-name">Quiz Name</label>
          <input
            type="text"
            value={quiz}
            onChange={({ target: { value } }) => setQuiz(value)}
            className="form-control"
            id="quiz-name"
          />
        </div>
        <div className="col-md-6 mb-3">
          <button type="submit" className="btn btn-primary mb-2">
            {props.quiz ? "Update" : "Add"} quiz
          </button>
        </div>
      </form>
    </Fragment>
  );
};

export default New;
