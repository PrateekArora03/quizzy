import React, { Fragment } from "react";
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
    <table className="table table-striped" {...getTableProps()}>
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

function QuizTable({ quizzes, setMessages }) {
  const deleteQuiz = async (id) => {
    try {
      const quizDelete = confirm("Are you sure you want to delete this Quiz?");
      if (quizDelete) {
        await API(`/quizzes/${id}`, "delete");
        window.location.href = "/";
      }
    } catch ({ response }) {
      response.data.type = "danger";
      setMessages(response.data);
    }
  };

  const columns = React.useMemo(
    () => [
      {
        Header: "Quiz Name",
        accessor: "name",
        Cell: (props) => (
          <a href={`/quizzes/${props.data[props.row.index].id}`}>
            {props.data[props.row.index].name}
          </a>
        ),
      },
      {
        Header: "Edit",
        accessor: "id",
        Cell: ({ value }) => (
          <a href={`/quizzes/${value}/edit`} className="btn btn-warning">
            Edit
          </a>
        ),
      },
      {
        Header: "Delete",
        Cell: (props) => (
          <button
            className="btn btn-danger"
            onClick={() => deleteQuiz(props.data[props.row.index].id)}
          >
            Delete
          </button>
        ),
      },
    ],
    []
  );

  return <Table columns={columns} data={quizzes} />;
}

export default QuizTable;
