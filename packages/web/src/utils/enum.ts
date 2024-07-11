export const isValidEnumValue = <T extends { [key: string]: string | number }>(
  value: unknown,
  enumObject: T
): value is T[keyof T] => {
  return Object.values(enumObject).includes(value as T[keyof T]);
};
