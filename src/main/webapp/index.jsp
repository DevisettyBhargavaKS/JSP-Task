
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="Com.CodeWithBhargav.Model.Task" %>
<html>
<head>
    <title>Task</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script>
        function toggleDeleteButton(checkboxId, buttonId) {
            var checkbox = document.getElementById(checkboxId);
            var deleteButton = document.getElementById(buttonId);
            deleteButton.disabled = checkbox.checked;
        }
    </script>
</head>
<body>
    <p class="fs-1 text-center">Welcome To Task Tracker</p>

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

    <table class="table table-hover container">
        <thead>
            <tr>
                <th>Id</th>
                <th>Task Status</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="task" items="${tasks}" varStatus="loop">
                <tr>
                    <td><c:out value="${task.id}" /></td>
                    <td><c:out value="${task.taskName }"/></td>

                    <td><c:out value="${task.description} " /></td>

                    <td>
                        <form action="task" method="post">
                            <label for="checkbox${loop.index}">
                                <input type="checkbox" id="checkbox${loop.index}" name="checkboxName" value="${task.id}" onclick="toggleDeleteButton('checkbox${loop.index}', 'deleteButton${loop.index}')">
                            </label>
                            <input type="hidden" name="action" value="Delete">
                            <input type="hidden" name="taskId" value="${task.id}">
                            <button class="btn btn-danger" type="submit" id="deleteButton${loop.index}" >Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>

            <!-- Display details of the added task within the table -->
            <c:if test="${temporaryTask != null}">
                                <tr>
                                    <td><c:out value="${temporaryTask.id}" /></td>
                                    <td><c:out value="${temporaryTask.taskName }"/></td>

                                    <td><c:out value="${temporaryTask.description} " /></td>
                                    <td>
                                <input type="checkbox" name="checkboxName">

                                 <button class="btn btn-danger" type="submit" >Delete</button></td>

</tr>

            </c:if>
        </tbody>
    </table>

    <!-- Note: Moved the "Save" button outside the table -->
    <div class="container d-flex justify-content-end">
        <form action="task" method="post">
            <button class="btn btn-primary mb-1" type="submit" name="action" value="Save">Save</button>
        </form>
    </div>
</body>
</html>

