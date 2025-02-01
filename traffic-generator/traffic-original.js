const axios = require('axios');

const USER_SERVICE_URL = process.env.USER_SERVICE_URL;
const PRODUCT_SERVICE_URL = process.env.PRODUCT_SERVICE_URL;
const ORDER_SERVICE_URL = process.env.ORDER_SERVICE_URL;
const PAYMENT_SERVICE_URL = process.env.PAYMENT_SERVICE_URL;

const generateTraffic = async () => {
  try {
    // Crear un usuario
    const userResponse = await axios.post(`${USER_SERVICE_URL}/users`, {
      name: "John Doe",
      email: "john.doe@example.com"
    });
    const userId = userResponse.data._id;

    // Crear un producto
    const productResponse = await axios.post(`${PRODUCT_SERVICE_URL}/products`, {
      name: "Laptop",
      price: 1200,
      stock: 10
    });
    const productId = productResponse.data._id;

    // Crear una orden
    const orderResponse = await axios.post(`${ORDER_SERVICE_URL}/orders`, {
      userId,
      products: [{ productId, quantity: 1 }]
    });
    const orderId = orderResponse.data._id;

    // Procesar el pago
    const paymentResponse = await axios.post(`${PAYMENT_SERVICE_URL}/payments`, {
      orderId,
      amount: 1200
    });

    console.log("Transaction completed:", paymentResponse.data);
  } catch (error) {
    console.error("Error generating traffic:", error.message);
  }
};

// Generar tráfico cada 5 segundos
setInterval(generateTraffic, 5000);
