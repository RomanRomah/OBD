const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log("--- Підключення до бази даних (PostgreSQL) ---");
  
  // Шукаємо клієнта з ID 1. Якщо немає - створюємо.
  let customer = await prisma.customers.findUnique({ where: { customer_id: 1 } });
  if (!customer) {
    console.log("Клієнта не знайдено. Створюємо нового...");
    customer = await prisma.customers.create({
      data: { first_name: "Тест", email: "test@ukr.net" }
    });
    console.log(`Створено нового клієнта з ID: ${customer.customer_id}`);
  }

  // Додаємо відгук
  console.log("--- Вставка даних у review ---");
  const newReview = await prisma.review.create({
    data: {
      customer_id: customer.customer_id,
      rating: 5,
      comment: "Ноутбук просто топ, літає!"
    }
  });
  console.log("Вставлено запис:", newReview);

  // Читаємо відгук
  console.log("--- Читання даних з review ---");
  const allReviews = await prisma.review.findMany();
  console.log("Знайдено записів:", allReviews);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });