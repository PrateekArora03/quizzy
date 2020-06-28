import React, { useRef, useState } from "react";
import { useTable } from "react-table";
import API from "../../utils/API";

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
  const jobId = useRef();
  const [csvFile, setCsvFile] = useState(null);
  const [loading, setLoading] = useState(false);

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

  const poll = async ({ callback, interval, maxAttempts }) => {
    const attempts = 0;
    const execPoll = async (resolve, reject) => {
      const result = await callback();
      attempts++;

      try {
        !(await result.clone().json()).processing;
      } catch (err) {
        return resolve(result);
      }

      if (maxAttempts && attempts == maxAttempts) {
        return reject(new Error("Exceeded max attempts"));
      } else {
        setTimeout(execPoll, interval, resolve, reject);
      }
    };

    return new Promise(execPoll);
  };

  const handleReport = async () => {
    try {
      setLoading(true);
      const response = await API("/reports/", "post");
      jobId.current = response.data.job_id;

      const pollForCsv = await poll({
        callback: fetchReport,
        interval: 5000,
        maxAttempts: 5,
      });

      if (!csvFile) {
        const csv = await pollForCsv.text();
        setCsvFile(csv);
      }
    } catch ({ response }) {
      console.error(response);
    }
  };

  const fetchReport = async () => {
    try {
      const response = await fetch(`/reports.csv?job_id=${jobId.current}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/csv",
          "X-CSRF-TOKEN": document.querySelector('[name="csrf-token"]').content,
        },
      });
      return response;
    } catch (err) {
      console.error(err);
    }
  };

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
      <div className="m-0 border-bottom w-100 row justify-content-between mt-2 pb-2">
        <h3>Reports</h3>
        {loading ? (
          !csvFile ? (
            <button className="btn btn-sm btn-outline-primary">
              <span
                className="spinner-grow spinner-grow-sm"
                role="status"
                aria-hidden="true"
              ></span>{" "}
              Processing Download
            </button>
          ) : (
            <button className="btn btn-sm btn-primary">
              <a
                style={{ color: "white", listStyleType: "none" }}
                href={`data:text/csv;charset=utf-8,${encodeURI(csvFile)}`}
                target="_blank"
                download="reports.csv"
              >
                Click to download
              </a>
            </button>
          )
        ) : (
          <button
            onClick={handleReport}
            className="btn btn-sm btn-outline-primary"
          >
            Download
          </button>
        )}
      </div>
      <Table columns={columns} data={data} />
    </div>
  );
}

export default Show;
