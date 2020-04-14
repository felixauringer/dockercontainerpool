FactoryBot.define do
  factory :coffee_script, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-coffee:latest' }
    file_type_id { 1 }
    help
    name { 'CoffeeScript' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'coffee' }
    singleton_execution_environment
  end

  factory :html, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-html:latest' }
    file_type_id { 1 }
    help
    name { 'HTML5' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'touch' }
    singleton_execution_environment
    test_command { 'rspec %{filename} --format documentation' }
    testing_framework { 'RspecAdapter' }
  end

  factory :java, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'openhpi/co_execenv_java:latest' }
    file_type_id { 1 }
    help
    name { 'Java 8' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'make run' }
    singleton_execution_environment
    test_command { 'make test CLASS_NAME="%{class_name}" FILENAME="%{filename}"' }
    testing_framework { 'JunitAdapter' }
  end

  factory :jruby, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-jruby:latest' }
    file_type_id { 1 }
    help
    name { 'JRuby 1.7' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'jruby %{filename}' }
    singleton_execution_environment
    test_command { 'rspec %{filename} --format documentation' }
    testing_framework { 'RspecAdapter' }
  end

  factory :node_js, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-node:latest' }
    file_type_id { 1 }
    help
    name { 'Node.js' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'node %{filename}' }
    singleton_execution_environment
  end

  factory :python, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'openhpi/co_execenv_python:latest' }
    file_type_id { 1 }
    help
    name { 'Python 3.4' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'python3 %{filename}' }
    singleton_execution_environment
    test_command { 'python3 -m unittest --verbose %{module_name}' }
    testing_framework { 'PyUnitAdapter' }
  end

  factory :ruby, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-ruby:latest' }
    file_type_id { 1 }
    help
    name { 'Ruby 2.2' }
    network_enabled { false }
    permitted_execution_time { 10.seconds }
    pool_size { 0 }
    run_command { 'ruby %{filename}' }
    singleton_execution_environment
    test_command { 'rspec %{filename} --format documentation' }
    testing_framework { 'RspecAdapter' }
  end

  factory :sinatra, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-sinatra:latest' }
    file_type_id { 1 }
    exposed_ports { '4567' }
    help
    name { 'Sinatra' }
    network_enabled { true }
    permitted_execution_time { 15.minutes }
    pool_size { 0 }
    run_command { 'ruby %{filename}' }
    singleton_execution_environment
    test_command { 'rspec %{filename} --format documentation' }
    testing_framework { 'RspecAdapter' }
  end

  factory :sqlite, class: ExecutionEnvironment do
    created_by_teacher
    default_memory_limit
    docker_image { 'hklement/ubuntu-sqlite:latest' }
    file_type_id { 1 }
    help
    name { 'SQLite' }
    network_enabled { false }
    permitted_execution_time { 1.minute }
    pool_size { 0 }
    run_command { 'sqlite3 /database.db -init %{filename} -html' }
    singleton_execution_environment
    test_command { 'ruby %{filename}' }
    testing_framework { 'SqlResultSetComparatorAdapter' }
  end

  trait :default_memory_limit do
    memory_limit { 50 }
  end

  trait :help do
    help { Forgery(:lorem_ipsum).words(Forgery(:basic).number(at_least: 50, at_most: 100)) }
  end

  trait :singleton_execution_environment do
    initialize_with { ExecutionEnvironment.where(name: name).first_or_create }
  end

  trait :created_by_teacher do
    user_id { 1 }
    user_type { 'ExternalUser' }
  end
end
