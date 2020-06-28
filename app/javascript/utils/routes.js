exports.reports_path = () => "/reports";
exports.quiz_path = (id) => `/quizzes/${id}`;
exports.quizzes_path = () => `/quizzes/`;
exports.new_question_path = (quizId) => `/quizzes/${quizId}/questions/new`;
exports.new_session_path = () => `/sessions/new`;
exports.attempts_path = (quizSlug) => `/public/${quizSlug}/attempts/`;
exports.edit_attempts_path = (quizSlug, attemptId) =>
  `/public/${quizSlug}/attempts/${attemptId}/edit`;
exports.attempt_path = (quizSlug, attemptId) =>
  `/public/${quizSlug}/attempts/${attemptId}/`;
