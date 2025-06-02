import { createBdd, test as base } from "playwright-bdd";

export const test: typeof base = base.extend({})

export const { Given, When, Then } = createBdd(test);