import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Playwright/);
});

test('get started link', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Click the get started link.
  await page.getByRole('link', { name: 'Get started' }).click();

  // Expects page to have a heading with the name of Installation.
  await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible();
});

test('screenshot', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Take a screenshot and save it to the 'screenshot.png' file.
  await page.screenshot({ path: 'screenshot.png' });

  // Expect the screenshot to be created.
  expect(await page.screenshot()).toBeDefined();
});
