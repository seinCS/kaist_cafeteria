const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const swaggerUi = require('swagger-ui-express');
const YAML = require('yamljs');

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// MongoDB 연결
mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/kaist_cafeteria', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Restaurant 스키마
const restaurantSchema = new mongoose.Schema({
  restaurantId: String,
  name: String,
  available: Boolean,
  waitingTime: Number,
  queueLength: Number,
  emptySeats: Number,
  congestionLevel: Number,
});

const Restaurant = mongoose.model('Restaurant', restaurantSchema);

// API 라우트
app.get('/api/restaurants', async (req, res) => {
  try {
    const restaurants = await Restaurant.find();
    res.json(restaurants);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Swagger 설정
const swaggerDocument = YAML.load('./swagger.yaml');
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
}); 