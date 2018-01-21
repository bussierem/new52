import { helper } from '@ember/component/helper';

const objectCategories = [
  'Animal',
  'Vegetable',
  'Mineral'
]

export function objectCategory([category]) {
  if(objectCategories.includes(category)) {
    return 'Normal'
  }
  return 'Other';
}

export default helper(objectCategory);
