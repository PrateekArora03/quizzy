import React from "react";
import { useTable } from "react-table";

function Table({ columns, data }) {
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({
    columns,
    data,
  });

  return (
    <table
      className="table table-bordered table-striped mt-5"
      {...getTableProps()}
    >
      <thead>
        {headerGroups.map((headerGroup) => (
          <tr {...headerGroup.getHeaderGroupProps()}>
            {headerGroup.headers.map((column) => (
              <th {...column.getHeaderProps()}>{column.render("Header")}</th>
            ))}
          </tr>
        ))}
      </thead>
      <tbody {...getTableBodyProps()}>
        {rows.map((row, i) => {
          prepareRow(row);
          return (
            <tr {...row.getRowProps()}>
              {row.cells.map((cell) => {
                return <td {...cell.getCellProps()}>{cell.render("Cell")}</td>;
              })}
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}

function Show({ quizzes }) {
  const data = [];
  quizzes.forEach((quiz) => {
    quiz.attempts.forEach((attempt) => {
      data.push({
        quiz: attempt.quiz,
        user: attempt.user.first_name + " " + attempt.user.last_name,
        email: attempt.user.email,
        correct_answer: attempt.correct_answers_count,
        incorrect_answers: attempt.incorrect_answers_count,
      });
    });
  });

  const columns = React.useMemo(
    () => [
      {
        Header: "Quiz Name",
        accessor: "quiz",
      },
      {
        Header: "User Name",
        accessor: "user",
      },
      {
        Header: "Email",
        accessor: "email",
      },
      {
        Header: "Correct Answer",
        accessor: "correct_answer",
      },
      {
        Header: "Incorrect Answer",
        accessor: "incorrect_answers",
      },
    ],
    []
  );

  return (
    <div>
      <div class="m-0 border-bottom w-100 row justify-content-between mt-2 pb-2">
        <h3>Reports</h3>
        <button class="btn btn-sm btn-outline-primary">Download</button>
      </div>
      <Table columns={columns} data={data} />
    </div>
  );
}

export default Show;
