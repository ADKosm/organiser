class MainController < ApplicationController
  def index
    @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @disciplines = Discipline.all
    @lessons = Array.new(7)
    @days.each_with_index do |val, index|
      @lessons[index] = Lesson.where(day: index)
    end
    @task_for_head = Array.new(7)
    week_begin = Time.now.beginning_of_week
    @task_for_head[0] = 5
    @days.each_with_index do |val, index|
      @task_for_head[index] = Task.where("deadline = ? and ready < ?", week_begin.advance(days: index).to_formatted_s(:org_db), 100)
    end

    @today_tasks = Task.where("ready < ?", 100).sort_by{|x| x.importance}.slice(0..5)

    @all_tasks = Task.order(:deadline).first(7)

  end
end