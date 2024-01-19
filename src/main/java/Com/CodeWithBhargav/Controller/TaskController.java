package Com.CodeWithBhargav.Controller;

import Com.CodeWithBhargav.Dao.TaskDao;
import Com.CodeWithBhargav.Model.Task;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TaskController extends HttpServlet {
    private final TaskDao taskDao;
    private final List<Task> temporaryTaskList;

    public TaskController() {
        taskDao = new TaskDao();
        temporaryTaskList = new ArrayList<>();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("Add".equals(action)) {
            String taskName = req.getParameter("task");
            String description = req.getParameter("description");
            Task temporaryTask = new Task(taskName, description);
            temporaryTaskList.add(temporaryTask);
            req.setAttribute("temporaryTask", temporaryTask);
        } else if ("Delete".equals(action)) {
            int taskId = Integer.parseInt(req.getParameter("taskId"));
            taskDao.deleteTask(taskId);
        } else if ("Save".equals(action)) {
            for (Task temporaryTask : temporaryTaskList) {
                taskDao.addTask(temporaryTask.getTaskName(), temporaryTask.getDescription());
            }
            temporaryTaskList.clear();
        }
        List<Task> taskList = taskDao.getTask();
        req.setAttribute("tasks", taskList);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Task> taskList = taskDao.getTask();
        req.setAttribute("tasks", taskList);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
