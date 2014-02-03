if (typeof tax === "undefined") {
  var tax = {};
}

// 非課税
tax.TAX_TYPE_NONTAXABLE = 1;
// 内税
tax.TAX_TYPE_INCLUSIVE = 2;
// 外税
tax.TAX_TYPE_EXCLUSIVE = 3;

tax.calcTaxAmount = function(taxType, amount) {
  if ( isNaN( amount ) ) {
    return '';
  }
    
  if ( taxType == tax.TAX_TYPE_INCLUSIVE ) {
    return parseInt(amount * 0.05 / 1.05);
  }
  else if ( taxType == tax.TAX_TYPE_EXCLUSIVE ) {
    return parseInt(amount * 0.05); 
  }

  return '';
};
