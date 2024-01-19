package Com.CodeWithBhargav.Dao;

import Com.CodeWithBhargav.Db.TaskDb;
import Com.CodeWithBhargav.Model.Task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TaskDao {
    private final Connection connection;
    private final String SELECT_TASK = "SELECT * FROM task";
    private final String DELETE_TASK = "DELETE FROM task WHERE id = ?";
    private final String INSERT_TASK = "INSERT INTO task (taskname, description) VALUES (?, ?)";

    public TaskDao() {
        connection = TaskDb.getConnection();
    }

    public void addTask(String taskName, String description) {
        try {
            PreparedStatement ps = connection.prepareStatement(INSERT_TASK);

            ps.setString(1, taskName);
            ps.setString(2, description);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Task> getTask() {
        List<Task> tasks = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(SELECT_TASK);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Task task = new Task();
                task.setId(resultSet.getInt("id"));
                task.setTaskName(resultSet.getString("taskname"));
                task.setDescription(resultSet.getString("description"));
                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public void deleteTask(int taskId) {
        try {
            PreparedStatement ps = connection.prepareStatement(DELETE_TASK);
            ps.setInt(1, taskId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
