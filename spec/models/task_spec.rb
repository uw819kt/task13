require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーション" do
    it "タイトルが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "ステータスが未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "完了期限が未入力の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end

    it "完了期限が過去の日付の場合、タスクのバリデーションが無効であること" do
      task = Task.new(title: "test", description: "test", status: :done, deadline: Time.current - 1.day)#1日引く
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline must start from today."]
    end

    it "完了期限が今日の日付の場合、タスクのバリデーションが有効であること" do
      task = Task.new(title: "test", description: "test", status: :done, deadline: Time.current.to_date)#今日の日付を指定
      expect(task).to be_valid
    end
  end
end

#すべてのテストにおいて、expectメソッドが使用されていること
#すべてのテストにおいて、バリデーションエラーが発生したかどうかの検証が行われていること
#バリデーションエラーが発生した際のエラーメッセージが想定通りかの検証が行われていること
#テストがすべて成功した際のスクリーンショットが提出されていること