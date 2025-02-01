const axios = require('axios');

const USER_SERVICE_URL = process.env.USER_SERVICE_URL;
const PRODUCT_SERVICE_URL = process.env.PRODUCT_SERVICE_URL;
const ORDER_SERVICE_URL = process.env.ORDER_SERVICE_URL;
const PAYMENT_SERVICE_URL = process.env.PAYMENT_SERVICE_URL;

// Función para generar un número aleatorio entre 0 y 1
const getRandom = () => Math.random();

// Función para simular una transacción errónea
const simulateError = () => {
  const random = getRandom();
  // 20% de probabilidad de error
  return random < 0.2;
};

const generateTraffic = async () => {
  try {
    console.log('Generating traffic...');

    // Simular un error aleatorio
    if (simulateError()) {
      throw new Error("Simulated error: Something went wrong with this transaction.");
    }

    // Crear un usuario
    const userResponse = await axios.post(`${USER_SERVICE_URL}/users`, {
      name: "John Doe",
      email: "john.doe@example.com"
    });
    const userId = userResponse.data._id;
    console.log('User created:', userId);

    // Crear un producto
    const productResponse = await axios.post(`${PRODUCT_SERVICE_URL}/products`, {
      name: "Laptop",
      price: 1200,
      stock: 10
    });
    const productId = productResponse.data._id;
    console.log('Product created:', productId);

    // Crear una orden
    const orderResponse = await axios.post(`${ORDER_SERVICE_URL}/orders`, {
      userId,
      products: [{ productId, quantity: 1 }]
    });
    const orderId = orderResponse.data._id;
    console.log('Order created:', orderId);

    // Procesar el pago
    const paymentResponse = await axios.post(`${PAYMENT_SERVICE_URL}/payments`, {
      orderId,
      amount: 1200
    });
    console.log('Payment processed:', paymentResponse.data);

    console.log('Transaction completed successfully!');
  } catch (error) {
    console.error('Error generating traffic:', error.message);
  }
};

// Generar tráfico cada 5 segundos
setInterval(generateTraffic, 5000);
