-- this table is to store the data we get from our sensor node
CREATE TABLE measurements (
time TIMESTAMPTZ NOT NULL, -- time is the name of the column, TIMESTAMPZ is the data type this one stores time with timezone, NOT NULL is a constraint which just means this column must always have a value
temp_c DOUBLE PRECISION, -- temperature in celsius because we are not crazy to measure it in Farenhiet and DOUBLE PERCISION is the data type so then we can store a decimal number with high percision
ph DOUBLE PRECISION,
do_mg DOUBLE PRECISION, --rookie mistake named this DO- disolved oxygen but for PostgreSQL DO is a reserved SQL keyword do I got an error instead I do do_mg it means dissolved oxygen per milligram
turbidity DOUBLE PRECISION,
battery DOUBLE PRECISION
);


