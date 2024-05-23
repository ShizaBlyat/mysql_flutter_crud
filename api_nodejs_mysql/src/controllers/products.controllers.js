import { pool } from "../db.js";

export const getProduct = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM products WHERE id = ?", [
      req.params.id,
    ]);
    if (rows.length <= 0)
      return res.status(404).json({
        message: "Product not found",
      });
    res.json(rows[0]);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const getProducts = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM products");
    res.json(rows);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const createProduct = async (req, res) => {
  const { code, description, price, quantity } = req.body;

  try {
    const [rows] = await pool.query(
      "INSERT INTO products (code, description, price, quantity) VALUES (?, ?, ?, ?)",
      [code, description, price, quantity]
    );
    res.send({ rows });
  } catch (error) {
    console.error(error);
    res.status(500).send("Error interno del servidor");
  }
};

export const deleteProduct = async (req, res) => {
  try {
    const [result] = await pool.query("DELETE FROM products WHERE id = ?", [
      req.params.id,
    ]);

    if (result.affectedRows <= 0)
      return res.status(404).json({
        message: "Not found product for delete",
      });

    res.sendStatus(204);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};

export const updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { code, description, price, quantity } = req.body;
    const [result] = await pool.query(
      "UPDATE products SET code = IFNULL(?, code), description = IFNULL(?, description), price = IFNULL(?, price), quantity = IFNULL(?, quantity) WHERE id = ?",
      [code, description, price, quantity, id]
    );
    console.log(result);

    if (result.affectedRows === 0)
      return res.status(404).json({
        message: "product not found",
      });

    const [rows] = await pool.query("SELECT * FROM products WHERE id = ?", [
      id,
    ]);

    res.json(rows[0]);
  } catch (error) {
    return res.status(500).json({
      message: "Error internal server",
    });
  }
};
