-- Insert customers
INSERT INTO customer (name) VALUES ('Acme Inc.'), ('Globex Corporation'), ('Wayne Enterprises');

-- Insert ad groups
INSERT INTO ad_group (name) VALUES ('Ad Group 1'), ('Ad Group 2'), ('Ad Group 3');

-- Insert solutions
INSERT INTO solution (name, customer_id) VALUES ('Solution 1', 1), ('Solution 2', 2), ('Solution 3', 3);

-- Insert components
INSERT INTO component (name) VALUES ('Component 1'), ('Component 2'), ('Component 3');

-- Insert solution components
INSERT INTO solution_component (solution_id, component_id) VALUES (1, 1), (1, 2), (2, 2), (2, 3), (3, 1), (3, 3);

-- Insert environments
INSERT INTO environment (name, solution_id) VALUES ('Environment 1', 1), ('Environment 2', 2), ('Environment 3', 3);

-- Insert virtual machines
INSERT INTO virtual_machine (name, specifications) VALUES ('VM 1', '{"cpu": 4, "memory": 16}'), ('VM 2', '{"cpu": 2, "memory": 8}'), ('VM 3', '{"cpu": 8, "memory": 32}');

-- Insert dedicated clusters
INSERT INTO dedicated_cluster (name, specifications) VALUES ('Dedicated Cluster 1', '{"cpu": 16, "memory": 64}'), ('Dedicated Cluster 2', '{"cpu": 32, "memory": 128}');

-- Insert shared clusters
INSERT INTO shared_cluster (name, specifications) VALUES ('Shared Cluster 1', '{"cpu": 8, "memory": 32}'), ('Shared Cluster 2', '{"cpu": 16, "memory": 64}');

-- Insert environment virtual machines
INSERT INTO environment_virtual_machine (environment_id, virtual_machine_id) VALUES (1, 1), (1, 2), (2, 2), (3, 3);

-- Insert environment dedicated clusters
INSERT INTO environment_dedicated_cluster (environment_id, dedicated_cluster_id) VALUES (1, 1), (2, 2), (3, 1), (3, 2);

-- Insert environment shared clusters
INSERT INTO environment_shared_cluster (environment_id, shared_cluster_id) VALUES (1, 1), (2, 2), (3, 1), (3, 2);

-- Insert namespaces
INSERT INTO namespace (name, environment_id) VALUES ('Namespace 1', 1), ('Namespace 2', 2), ('Namespace 3', 3);