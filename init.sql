CREATE TABLE IF NOT EXISTS customer (
  customer_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ad_group (
  ad_group_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS solution (
  solution_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  customer_id INT
);

CREATE TABLE IF NOT EXISTS component (
  component_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS solution_component (
  solution_id INT,
  component_id INT,
  PRIMARY KEY (solution_id, component_id)
);

CREATE TABLE IF NOT EXISTS environment (
  environment_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  solution_id INT
);

CREATE TABLE IF NOT EXISTS virtual_machine (
  virtual_machine_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSONB
);

CREATE TABLE IF NOT EXISTS dedicated_cluster (
  dedicated_cluster_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSONB
);

CREATE TABLE IF NOT EXISTS shared_cluster (
  shared_cluster_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specifications JSONB
);

CREATE TABLE IF NOT EXISTS environment_virtual_machine (
  environment_id INT,
  virtual_machine_id INT,
  PRIMARY KEY (environment_id, virtual_machine_id)
);

CREATE TABLE IF NOT EXISTS environment_dedicated_cluster (
  environment_id INT,
  dedicated_cluster_id INT,
  PRIMARY KEY (environment_id, dedicated_cluster_id)
);

CREATE TABLE IF NOT EXISTS environment_shared_cluster (
  environment_id INT,
  shared_cluster_id INT,
  PRIMARY KEY (environment_id, shared_cluster_id)
);

CREATE TABLE IF NOT EXISTS namespace (
  namespace_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  environment_id INT
);

ALTER TABLE customer DROP CONSTRAINT IF EXISTS fk_customer_ad_group;
ALTER TABLE solution DROP CONSTRAINT IF EXISTS fk_solution_customer;
ALTER TABLE solution_component DROP CONSTRAINT IF EXISTS fk_solution_component_solution;
ALTER TABLE solution_component DROP CONSTRAINT IF EXISTS fk_solution_component_component;
ALTER TABLE environment DROP CONSTRAINT IF EXISTS fk_environment_solution;
ALTER TABLE namespace DROP CONSTRAINT IF EXISTS fk_namespace_environment;
ALTER TABLE customer ADD CONSTRAINT fk_customer_ad_group FOREIGN KEY (ad_group_id) REFERENCES ad_group(ad_group_id);
ALTER TABLE solution ADD CONSTRAINT fk_solution_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);
ALTER TABLE solution_component ADD CONSTRAINT fk_solution_component_solution FOREIGN KEY (solution_id) REFERENCES solution(solution_id);
ALTER TABLE solution_component ADD CONSTRAINT fk_solution_component_component FOREIGN KEY (component_id) REFERENCES component(component_id);
ALTER TABLE environment ADD CONSTRAINT fk_environment_solution FOREIGN KEY (solution_id) REFERENCES solution(solution_id);
ALTER TABLE namespace ADD CONSTRAINT fk_namespace_environment FOREIGN KEY (environment_id) REFERENCES environment(environment_id);
ALTER TABLE environment_virtual_machine ADD CONSTRAINT fk_environment_virtual_machine_environment FOREIGN KEY (environment_id) REFERENCES environment(environment_id);
ALTER TABLE environment_virtual_machine ADD CONSTRAINT fk_environment_virtual_machine_virtual_machine FOREIGN KEY (virtual_machine_id) REFERENCES virtual_machine(virtual_machine_id);
ALTER TABLE environment_dedicated_cluster ADD CONSTRAINT fk_environment_dedicated_cluster_environment FOREIGN KEY (environment_id) REFERENCES environment(environment_id);
ALTER TABLE environment_dedicated_cluster ADD CONSTRAINT fk_environment_dedicated_cluster_dedicated_cluster FOREIGN KEY (dedicated_cluster_id) REFERENCES dedicated_cluster(dedicated_cluster_id);
ALTER TABLE environment_shared_cluster ADD CONSTRAINT fk_environment_shared_cluster_environment FOREIGN KEY (environment_id) REFERENCES environment(environment_id);
ALTER TABLE environment_shared_cluster ADD CONSTRAINT fk_environment_shared_cluster_shared_cluster FOREIGN KEY (shared_cluster_id) REFERENCES shared_cluster(shared_cluster_id);