require_relative 'questiondb.rb'
require_relative 'question.rb'
require_relative 'reply.rb'


class User
    attr_accessor :id,:fname, :lname 
    def self.find_by_id(id)
        find_user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT 
                *
            FROM
                users
            WHERE
                id = ?
           SQL
        
        # find_user.map{ |user| User.new(user) }
        return nil if find_user.empty?
        new_user=User.new(find_user.first)
    end

    def self.find_by_name(fname, lname)
        find_user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT 
            *
        FROM
            users
        WHERE
            fname = ? AND lname = ?
       SQL

       return nil if find_user.empty?
        find_user.map{ |user| User.new(user) }
    end


    def initialize( options )
       @id = options['id']
       @fname = options['fname']
       @lname = options['lname'] 
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end
    
    def authored_replies 
        Reply.find_by_user_id(self.id)
    end
    

    
end