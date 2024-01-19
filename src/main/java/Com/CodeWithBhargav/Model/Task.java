package Com.CodeWithBhargav.Model;

public class Task {
    private int id;
    private String taskName;
    private String description;
    public Task(String taskName, String description) {
        this.taskName = taskName;
        this.description = description;
    }


    public Task() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
