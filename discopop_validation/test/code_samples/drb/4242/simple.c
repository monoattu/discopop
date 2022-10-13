int main()
{
  int i, dummy, n=10, sum;
  double a[10];

  for(i=0;i<n; i++) 
    a[i]=(double)(i);

  for(i=0;i<n; i++)
    a[i] = a[(i-1)%10];
  
  dummy = a[3] + a[2];

  for(i=0;i<n; i++){
    sum += a[i];
  }     

  return 0;
}
