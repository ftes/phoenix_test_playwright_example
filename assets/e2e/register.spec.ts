import { test, expect } from "@playwright/test";

const testSuites = Number.parseInt(process.env.T);
const iterationsWithinTest = 10;

Array.from({ length: testSuites }).map((_, i) => {
  test(`register ${i}`, async ({ page }) => {
    for (let i = 0; i < iterationsWithinTest; i++) {
      const email = `f${Math.random()}@ftes.de`;

      await page.goto("http://localhost:4000/");
      await page.getByRole("link", { name: "Register" }).click();
      await expect(page.locator(".phx-connected")).toBeVisible();
      await page.getByLabel("Email").fill(email);
      await page.getByRole("button", { name: "Create an account" }).click();
      await expect(
        page.locator("#flash-info").getByText("email was sent"),
      ).toBeVisible();
      await page.goto("http://localhost:4000/dev/mailbox");
      await page
        .getByRole("link", { name: `Confirmation instructions ${email}` })
        .click();
      await page.getByRole("link", { name: "log-in" }).click();
      await expect(page.locator(".phx-connected")).toBeVisible();
      await page
        .getByRole("button", { name: "Confirm and stay logged in" })
        .click();
      await expect(
        page.locator("#flash-info").getByText("User confirmed"),
      ).toBeVisible();
      await page.goto("http://localhost:4000/users/settings");
      await expect(page.locator(".phx-connected")).toBeVisible();
      await page.getByRole("heading", { name: "Settings" }).click();
      await page.getByRole("link", { name: "Log out" }).click();
    }
  });
});
