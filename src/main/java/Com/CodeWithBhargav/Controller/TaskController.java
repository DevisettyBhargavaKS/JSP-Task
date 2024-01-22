package Com.CodeWithBhargav.Controller;

import Com.CodeWithBhargav.Dao.TaskDao;
import Com.CodeWithBhargav.Model.Task;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
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
            req.setAttribute("temporaryTasks", temporaryTaskList);
        } else if ("Delete".equals(action)) {
            String[] taskIds = req.getParameterValues("checkboxName");
            if (taskIds != null) {
                for (String taskIdStr : taskIds) {
                    int taskId = Integer.parseInt(taskIdStr);

                    // Use an iterator to safely remove items from the list
                    Iterator<Task> iterator = temporaryTaskList.iterator();
                    while (iterator.hasNext()) {
                        Task temporaryTask = iterator.next();
                        if (temporaryTask.getId() == taskId) {
                            iterator.remove();
                            break;  // Exit the loop after deleting the task
                        }
                    }
                }
            }
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
