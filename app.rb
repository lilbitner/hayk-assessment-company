class Company 

    attr_accessor :name, :number_of_employees 

    def initialize(name, number_of_employees)
        @name = name 
        @number_of_employees = number_of_employees
    end 

    Company.create_table 


    def new_company
        INSERT INTO companies (name, number_of_employees) VALUES ("Johnson", 1000)
    end 

    def save 
        sql = <<-SQL 
            INSERT INTO songs (name, number_of_employees)
            VALUES (?, ?)
        SQL 

        DB[:conn].execute(sql, self.name, self.number_of_employees)

    end

    def self.new_from_db(row)
        new_company = self.new 
        new_company.id = row[0]
        new_company.name =  row[1]
        new_company.number_of_employees = row[2]
        new_company
      end



    def find_by_name(name)
        sql = <<-SQL 
        SELECT *
        FROM companies
        WHERE name = ?
        LIMIT 1
    SQL

        DB[:conn].execute(sql, name).map do |row|
            self.new_from_db(row)
        end.first 

    end 

    def self.all 
        sql = <<-SQL 
            SELECT * 
            FROM songs 
        SQL 

        DB[:conn].execute(sql)
    end 

    cereal = Company.new("Kellogs", 6000)
    cereal.save 

end 






In `app.rb`, create a Ruby class `Company` that can:

* Create a new company with a name and number of employees without saving
* Save an instance and persist it to a database
* Find a company by name
* List all companies
* Update a changed company and save it to a database
* Delete a company