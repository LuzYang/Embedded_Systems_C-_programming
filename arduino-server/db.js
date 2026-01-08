const sqlite3 = require('sqlite3').verbose();

// 打开或创建数据库（文件名：data.db）
const db = new sqlite3.Database('./data.db');

// 创建表（如果不存在）
db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS sensor_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      temperature REAL,
      humidity REAL,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
});

module.exports = db;
