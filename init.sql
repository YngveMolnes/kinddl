-- Table: Customer
CREATE TABLE IF NOT EXISTS Customer (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  ad_group_id INT
);

-- Table: ADGroup
CREATE TABLE IF NOT EXISTS ADGroup (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

-- Table: Solution
CREATE TABLE IF NOT EXISTS Solution (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  customer_id INT
);

-- Table: Component
CREATE TABLE IF NOT EXISTS Component (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

-- Table: SolutionComponent
CREATE TABLE IF NOT EXISTS SolutionComponent (
  id SERIAL PRIMARY KEY,
  solution_id INT,
  component_id INT
);

-- Table: Environment
CREATE TABLE IF NOT EXISTS Environment (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  solution_id INT,
  vm_id INT,
  dedicated_cluster_id INT,
  shared_cluster_id INT
);

-- Table: VirtualMachine
CREATE TABLE IF NOT EXISTS VirtualMachine (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSON
);

-- Table: DedicatedCluster
CREATE TABLE IF NOT EXISTS DedicatedCluster (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSON
);

-- Table: SharedCluster
CREATE TABLE IF NOT EXISTS SharedCluster (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSON
);

-- Table: Namespace
CREATE TABLE IF NOT EXISTS Namespace (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  environment_id INT
);

-- Add foreign key constraints
ALTER TABLE Customer ADD CONSTRAINT fk_customer_adgroup FOREIGN KEY (ad_group_id) REFERENCES ADGroup(id);
ALTER TABLE Solution ADD CONSTRAINT fk_solution_customer FOREIGN KEY (customer_id) REFERENCES Customer(id);
ALTER TABLE SolutionComponent ADD CONSTRAINT fk_solutioncomponent_solution FOREIGN KEY (solution_id) REFERENCES Solution(id);
ALTER TABLE SolutionComponent ADD CONSTRAINT fk_solutioncomponent_component FOREIGN KEY (component_id) REFERENCES Component(id);
ALTER TABLE Environment ADD CONSTRAINT fk_environment_solution FOREIGN KEY (solution_id) REFERENCES Solution(id);
ALTER TABLE Namespace ADD CONSTRAINT fk_namespace_environment FOREIGN KEY (environment_id) REFERENCES Environment(id);

