import { pool } from "../db.js";

export const getEmployee = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM employees WHERE id = ?", [
      req.params.id,
    ]);
    if (rows.length <= 0)
      return res.status(404).json({
        message: "Employee not found",
      });
    res.json(rows[0]);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const getEmployees = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM employees");
    res.json(rows);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const createEmployee = async (req, res) => {
  const { name, position, salary, department, description } = req.body;

  try {
    const [rows] = await pool.query(
      "INSERT INTO employees (name, position, salary, department, description) VALUES (?, ?, ?, ?, ?)",
      [name, position, salary, department, description]
    );
    res.send({ rows });
  } catch (error) {
    console.error(error);
    res.status(500).send("Error interno del servidor");
  }
};

export const deleteEmployee = async (req, res) => {
  try {
    const [result] = await pool.query("DELETE FROM employees WHERE id = ?", [
      req.params.id,
    ]);

    if (result.affectedRows <= 0)
      return res.status(404).json({
        message: "Not found employee for delete",
      });

    res.sendStatus(204);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const updateEmployee = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, position, salary, department, description } = req.body;
    const [result] = await pool.query(
      "UPDATE employees SET name = IFNULL(?, name), position = IFNULL(?, position), salary = IFNULL(?, salary), department = IFNULL(?, department), description = IFNULL(?, description) WHERE id = ?",
      [name, position, salary, department, description, id]
    );
    console.log(result);

    if (result.affectedRows === 0)
      return res.status(404).json({
        message: "Employee not found",
      });

    const [rows] = await pool.query("SELECT * FROM employees WHERE id = ?", [
      id,
    ]);

    res.json(rows[0]);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};
