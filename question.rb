require_relative 'questiondb.rb'
require_relative 'user.rb'
require_relative 'reply.rb'

class Question
    attr_accessor :id,:title, :body, :a_author_id

    def self.find_by_id(id)
       questions = QuestionsDatabase.instance.execute(<<-SQL, id) 
        SELECT 
            * 
        FROM 
            questions 
        WHERE 
            id = ?
       SQL
       return nil if questions.empty?
       question = Question.new(questions.first)
    end

    def self.find_by_author_id(a_author_id)
        q_authors = QuestionsDatabase.instance.execute(<<-SQL, a_author_id)
        SELECT 
            *
        FROM 
            questions
        WHERE
            a_author_id = ?
        SQL
        return nil if q_authors.empty?
       q_authors.map {|author| Question.new(author)}
        
    end
    
    
    
    
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @a_author_id = options['a_author_id']
    end
    
    def author
       name = QuestionsDatabase.instance.execute(<<-SQL, self.a_author_id)
        SELECT
         *
         FROM
            users
        WHERE 
            id = ? 
        SQL
        User.new(name.first) 
    end
    
    def replies
        Reply.find_by_question_id(self.id)
    end
    
    
    
end