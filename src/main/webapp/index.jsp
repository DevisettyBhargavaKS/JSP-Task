<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="Com.CodeWithBhargav.Model.Task" %>
<html>
<head>
    <title>Task Tracker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <div class="container mt-5">
        <h1 class="display-3 text-center">Welcome To Task Tracker</h1>

        <form action="task" method="post">
            <p class="text-center fs-5">Select Task Status:
                <select name="task">
                    <option value="">--Select--</option>
                    <option value="Remainder">Remainder</option>
                    <option value="Todo">Todo</option>
                    <option value="Follow Up">Follow Up</option>
                </select><br>
                Description:<textarea name="description" class="mt-4" placeholder="Enter Task Description"></textarea><br>
                <button class="btn btn-primary mb-1" type="submit" name="action" value="Add">Add</button>
            </p>
        </form>

        <table class="table table-hover mt-5">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Task Status</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <!-- Display tasks (regular and temporary) -->
                <c:set var="counter" value="0" scope="page" />

                <c:forEach var="task" items="${tasks}" varStatus="loop">
                    <tr>
                        <td>${counter + 1}</td>
                        <td><c:out value="${task.taskName }"/></td>
                        <td><c:out value="${task.description} " /></td>
                        <td>
                            <form action="task" method="post">
                                <label for="checkbox${loop.index}">
                                    <input type="checkbox" id="checkbox${loop.index}" name="checkboxName" value="${task.id}" onclick="toggleDeleteButton('checkbox${loop.index}', 'deleteButton${loop.index}')">
                                </label>
                                <input type="hidden" name="action" value="Delete">
                                <input type="hidden" name="taskId" value="${task.id}">
                                <button class="btn btn-danger" type="submit" id="deleteButton${loop.index}">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}" scope="page" />
                </c:forEach>

                <!-- Display details of the added temporary tasks, if any -->
                <c:forEach var="temporaryTask" items="${temporaryTasks}" varStatus="loop">
                    <tr>
                        <td>${counter + 1}</td>
                        <td><c:out value="${temporaryTask.taskName }"/></td>
                        <td><c:out value="${temporaryTask.description} " /></td>
                        <td>
                            <form action="task" method="post">
                                <label for="checkboxTemporary${loop.index}">
                                    <input type="checkbox" id="checkboxTemporary${loop.index}" name="checkboxNameTemporary" value="${temporaryTask.id}" onclick="toggleDeleteButton('checkboxTemporary${loop.index}', 'deleteButtonTemporary${loop.index}')">
                                </label>
                                <input type="hidden" name="action" value="Delete">
                                <input type="hidden" name="taskId" value="${temporaryTask.id}">
                                <button class="btn btn-danger" type="submit" id="deleteButtonTemporary${loop.index}">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <c:set var="counter" value="${counter + 1}" scope="page" />
                </c:forEach>
            </tbody>
        </table>

        <!-- Note: Moved the "Save" button outside the table -->
        <div class="container d-flex justify-content-end mt-3">
            <form action="task" method="post">
                <button class="btn btn-primary" type="submit" name="action" value="Save">Save</button>
            </form>
        </div>
    </div>

    <script>
        function toggleDeleteButton(checkboxId, buttonId) {
            var checkbox = document.getElementById(checkboxId);
            var deleteButton = document.getElementById(buttonId);
            deleteButton.disabled = checkbox.checked;
        }
    </script>
</body>
</html>
