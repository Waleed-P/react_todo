import React, { useState } from "react";
import { Button, Form, ListGroup, Container, Row, Col } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";

function App() {
  const [tasks, setTasks] = useState([]);
  const [taskText, setTaskText] = useState("");

  const handleAddTask = () => {
    if (taskText.trim() !== "") {
      setTasks([...tasks, { text: taskText, completed: false }]);
      setTaskText("");
    }
  };

  const handleToggleCompletion = (index) => {
    setTasks(
      tasks.map((task, i) =>
        i === index ? { ...task, completed: !task.completed } : task
      )
    );
  };

  const handleDeleteTask = (index) => {
    setTasks(tasks.filter((_, i) => i !== index));
  };

  return (
    <Container className="mt-4">
      <Row>
        <Col md={6} className="mx-auto">
          <h1 className="text-center mb-4">Todo App</h1>
          <Form className="d-flex mb-3">
            <Form.Control
              type="text"
              placeholder="Enter a task"
              value={taskText}
              onChange={(e) => setTaskText(e.target.value)}
            />
            <Button className="ms-2" onClick={handleAddTask}>
              Add Task
            </Button>
          </Form>
          <ListGroup>
            {tasks.map((task, index) => (
              <ListGroup.Item
                key={index}
                className="d-flex justify-content-between align-items-center"
                variant={task.completed ? "success" : ""}
              >
                <span
                  onClick={() => handleToggleCompletion(index)}
                  style={{
                    textDecoration: task.completed ? "line-through" : "none",
                    cursor: "pointer",
                  }}
                >
                  {task.text}
                </span>
                <div>
                  <Button
                  className="me-3"
                    variant={task.completed ? "primary" : "success"}
                    size="sm"
                    onClick={() => handleToggleCompletion(index)}
                  >
                    {task.completed ? "Mark as uncomplete" : "Mark as completed"}
                  </Button>
                  <Button
                    variant="danger"
                    size="sm"
                    onClick={() => handleDeleteTask(index)}
                  >
                    Delete
                  </Button>
                </div>
              </ListGroup.Item>
            ))}
          </ListGroup>
        </Col>
      </Row>
    </Container>
  );
}

export default App;
