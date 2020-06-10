import React, { Fragment, useState } from "react";
import QuizTable from "./QuizTable";
import Alert from "../layouts/Alert";

const Index = ({ quizzes }) => {
  const [messages, setMessages] = useState({});

  return (
    <Fragment>
      {Object.keys(messages).length > 0 && <Alert messages={messages} />}
      <div className="d-flex justify-content-end">
        <a href="/quizzes/new" className="btn btn-primary">
          Add new quiz
        </a>
      </div>
      <div className="d-flex mt-3 justify-content-center">
        {quizzes.length > 0 ? (
          <QuizTable quizzes={quizzes} setMessages={setMessages} />
        ) : (
          <span className="text-muted">You have not created any quiz.</span>
        )}
      </div>
    </Fragment>
  );
};

export default Index;
