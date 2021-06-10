require_relative 'questiondb.rb'
require_relative 'user.rb'
require_relative 'question.rb'
class QuestionFollow

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT 
            users.id, users.fname, users.lname 
        FROM 
          question_follows  
          JOIN 
          users ON users.id = question_follows.user_id
        WHERE
            question_id = ?
        SQL
        followers.map {|follow| User.new(follow)}
  end
  
  def self.followers_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT 
        questions.id, questions.title, questions.body, questions.a_author_id
        FROM 
          question_follows  
          JOIN 
          questions ON questions.id = question_follows.question_id
        WHERE
            user_id = ?
        SQL
        questions.map {|q| Question.new(q)}
  end
  
  
  
  
end